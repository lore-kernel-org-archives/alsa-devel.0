From: John Spencer <maillist-alsa@barfooze.de>
Subject: horribly wrong code when --with-versioned is active
Date: Mon, 05 Aug 2013 23:46:09 +0200
Message-ID: <52001D21.6060203@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 27794265274
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 23:52:05 +0200 (CEST)
Received: from xdsl-188-155-204-150.adslplus.ch ([188.155.204.150]
 helo=[10.1.1.4])
 by furnace.wzff.de with esmtpsa (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
 (Exim 4.80.1 (FreeBSD)) (envelope-from <maillist-alsa@barfooze.de>)
 id 1V6ShA-000BH2-H9
 for alsa-devel@alsa-project.org; Mon, 05 Aug 2013 23:52:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

if --with-versioned is active (default), a couple of macros in pcm.c
start generating some completely broken, __old-prefixed wrapper 
functions, which then are getting used whenever the actual function is 
called.

for example:
snd_pcm_hw_params_set_buffer_time_near

__OLD_NEAR1(snd_pcm_hw_params_set_buffer_time_near, unsigned int);

->

#define __OLD_NEAR1(name, ret_type) __P_OLD_NEAR1(__old_, name, ret_type)

->

#define __P_OLD_NEAR1(pfx, name, ret_type) \
ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, ret_type 
val, int *dir) \
{ \
         if (INTERNAL(name)(pcm, params, &val, dir) < 0) \
                 return 0; \
         return (ret_type)val; \
}

this will lead to generating a function 
__old_snd_pcm_hw_params_set_buffer_time_near which expands to

unsigned int __old_snd_pcm_hw_params_set_buffer_time_near(snd_pcm_t 
*pcm, snd_pcm_hw_params_t *params, ret_type val, int *dir)
{
         if snd1_pcm_hw_params_set_buffer_time_near(pcm, params, &val, 
dir) < 0)
                 return 0;
         return (ret_type)val;
}

there 2 bugs in there,
1) the real function gets passed a pointer to a pointer of unsigned, 
which is then happily dereferenced and the original pointer used as an 
int, and
2) the return type logic is wrong, in case of a non-error, the original 
pointer will be returned instead of 0 to indicate success.

the right fix would look something like this:

@@ -7190,19 +7192,15 @@
  __OLD_GET1(snd_pcm_hw_params_get_tick_time_max, unsigned int, unsigned 
int);

  #define __P_OLD_NEAR(pfx, name, ret_type) \
-ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, 
ret_type val) \
+ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, 
ret_type *val) \
  { \
-	if (INTERNAL(name)(pcm, params, &val) < 0) \
-		return 0; \
-	return (ret_type)val; \
+	return(INTERNAL(name)(pcm, params, val)); \
  }

  #define __P_OLD_NEAR1(pfx, name, ret_type) \
-ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, 
ret_type val, int *dir) \
+ret_type pfx##name(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, 
ret_type *val, int *dir) \
  { \
-	if (INTERNAL(name)(pcm, params, &val, dir) < 0) \
-		return 0; \
-	return (ret_type)val; \
+	return (INTERNAL(name)(pcm, params, val, dir) < 0); \
  }

  #define __OLD_NEAR(name, ret_type) __P_OLD_NEAR(__old_, name, ret_type)


this is only half of the fix though, the "old" getter functions seem to 
misbehave as well. the misbehaviour can be inspected by using a small 
openal-soft (version 1.14) example code, and breaking on 
alsa_reset_playback and single stepping through the invocation of 
CHECK(snd_pcm_hw_params_set_buffer_time_near(data->pcmHandle, hp, 
&bufferLen, NULL));
