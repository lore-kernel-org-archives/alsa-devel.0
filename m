From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Re: Inexplicable mixer control creation
Date: Fri, 16 Mar 2007 13:45:08 -0400
Message-ID: <45FAD7A4.4040408@earthlink.net>
References: <45F1830D.9020609@earthlink.net>	<s5hodmyr6j9.wl%tiwai@suse.de>	<45F73FF4.1000902@earthlink.net>
	<s5hslc5us22.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1425991865=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mta9.adelphia.net (mta9.adelphia.net [68.168.78.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F84E245DA
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2007 18:45:25 +0100 (CET)
In-Reply-To: <s5hslc5us22.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============1425991865==
Content-Type: multipart/alternative;
	boundary="------------090109070200040707030301"

This is a multi-part message in MIME format.
--------------090109070200040707030301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 13 Mar 2007 20:21:08 -0400,
> Randy Cushman wrote:
>   
>> In attempting to implement my proposed mixer control name changes (see 
>> "[Alsa-devel] RFC: Enhance AD AC '97 mixer control names") I have 
>> encountered behavior that makes no sense to me:  If module 
>> snd_ac97_codec does not create a control with the name 'PCM Playback 
>> Volume' then something else creates a control with that name.  Not 
>> surprisingly, this phantom control serves no useful purpose in my 
>> environment, as it has no affect on AC '97 control registers.
>>     
>
> This is done by softvol plugin used in the default configuration for
> many onboard chip drivers.  See alsa-lib/src/conf/cards/*.conf.
>
>   
I haven't spent much time in alsa-lib.  I'll take a look.

This may be a good time to mention that I am unable to access the 
Mercurial repository.  If I try to access 
http://hg-mirror.alsa-project.org in a web browser or use the "hg clone" 
command, I get "HTTP Error 403: Forbidden".  Curiously, I can "hg diff" 
repositories I cloned previously.  (I opened bugtrack ticket #2956 this 
morning.)

In the mean time, I'll look at alsa-lib-1.0.14rc3.

> That's actually a point that I missed.  Many apps assume either
> "Master" or "PCM" mixer exists.  Thus, removing PCM isn't nice for
> them. 
>
>
> Now I'm considering whether changing the volume names in the driver
> level is actually a better choice.  It's basically simpler, and I
> prefer a simpler solution.  OTOH, it may bring other messes because of
> the name incompatibility like above.  So, the cleanest solution would
> be some mangling in the user-space, i.e. inside alsa-lib.  But, it's
> a bit harder way.
>
>   
I was planning to change the names by calling snd_ac97_rename_vol_ctl() 
from functions patch_ad1986_specific(), etc. in ac97_patch.c.  I'll 
explore the alsa-lib approach.

> So, before doing this -- we have to *seriously* consider to get
> consensus what control names should be used as standard and how they
> behave.  Maybe better to start another thread for discussing this...
>
>   
I can start another thread.
> Takashi
>
>
>   


--------------090109070200040707030301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Takashi Iwai wrote:
<blockquote cite="mids5hslc5us22.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">At Tue, 13 Mar 2007 20:21:08 -0400,
Randy Cushman wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">In attempting to implement my proposed mixer control name changes (see 
"[Alsa-devel] RFC: Enhance AD AC '97 mixer control names") I have 
encountered behavior that makes no sense to me:  If module 
snd_ac97_codec does not create a control with the name 'PCM Playback 
Volume' then something else creates a control with that name.  Not 
surprisingly, this phantom control serves no useful purpose in my 
environment, as it has no affect on AC '97 control registers.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is done by softvol plugin used in the default configuration for
many onboard chip drivers.  See alsa-lib/src/conf/cards/*.conf.

  </pre>
</blockquote>
I haven't spent much time in alsa-lib.&nbsp; I'll take a look.<br>
<br>
This may be a good time to mention that I am unable to access the
Mercurial repository.&nbsp; If I try to access
<a class="moz-txt-link-freetext" href="http://hg-mirror.alsa-project.org">http://hg-mirror.alsa-project.org</a> in a web browser or use the "hg
clone" command, I get "HTTP Error 403: Forbidden".&nbsp; Curiously, I can
"hg diff" repositories I cloned previously.&nbsp; (I opened bugtrack ticket
#2956 this morning.)<br>
<br>
In the mean time, I'll look at alsa-lib-1.0.14rc3.<br>
<br>
<blockquote cite="mids5hslc5us22.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">That's actually a point that I missed.  Many apps assume either
"Master" or "PCM" mixer exists.  Thus, removing PCM isn't nice for
them. 


Now I'm considering whether changing the volume names in the driver
level is actually a better choice.  It's basically simpler, and I
prefer a simpler solution.  OTOH, it may bring other messes because of
the name incompatibility like above.  So, the cleanest solution would
be some mangling in the user-space, i.e. inside alsa-lib.  But, it's
a bit harder way.

  </pre>
</blockquote>
I was planning to change the names by calling snd_ac97_rename_vol_ctl()
from functions patch_ad1986_specific(), etc. in ac97_patch.c.&nbsp; I'll
explore the alsa-lib approach.<br>
<br>
<blockquote cite="mids5hslc5us22.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">So, before doing this -- we have to *seriously* consider to get
consensus what control names should be used as standard and how they
behave.  Maybe better to start another thread for discussing this...

  </pre>
</blockquote>
I can start another thread.<br>
<blockquote cite="mids5hslc5us22.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">
Takashi


  </pre>
</blockquote>
<br>
</body>
</html>

--------------090109070200040707030301--



--===============1425991865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1425991865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1425991865==--
