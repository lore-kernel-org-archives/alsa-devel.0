From: GitHub issues - opened <github@alsa-project.org>
Subject: 1.1.8: compile warnings
Date: Mon,  6 May 2019 14:56:34 +0200 (CEST)
Message-ID: <20190506125634.DCEF7F896FD@alsa1.perex.cz>
References: <1557147392221450090-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B0B5BF896E6
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 14:56:32 +0200 (CEST)
In-Reply-To: <1557147392221450090-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-utils issue #17 was opened from kloczek:

It would be good to clean this :)
<pre>alsactl.c: In function &apos;main&apos;:
alsactl.c:345:3: warning: ignoring return value of &apos;daemon&apos;, declared with attribute warn_unused_result [-Wunused-result]
  345 |   daemon(0, 0);
      |   ^~~~~~~~~~~~
utils.c: In function &apos;initfailed&apos;:
utils.c:95:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
   95 |  write(fp, str, strlen(str));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
utils.c:96:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
   96 |  write(fp, &quot;:&quot;, 1);
      |  ^~~~~~~~~~~~~~~~~
utils.c:97:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
   97 |  write(fp, reason, strlen(reason));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
utils.c:98:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
   98 |  write(fp, &quot;:&quot;, 1);
      |  ^~~~~~~~~~~~~~~~~
utils.c:99:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
   99 |  write(fp, sexitcode, strlen(sexitcode));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
utils.c:100:2: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
  100 |  write(fp, &quot;\n&quot;, 1);
      |  ^~~~~~~~~~~~~~~~~~
Note: Writing alsactl_init.7
mem.c: In function &apos;casprintf&apos;:
mem.c:63:6: warning: implicit declaration of function &apos;vasprintf&apos;; did you mean &apos;casprintf&apos;? [-Wimplicit-function-declaration]
   63 |  if (vasprintf(&amp;str, fmt, ap) &lt; 0)
      |      ^~~~~~~~~
      |      casprintf
utils.c:19: warning: &quot;_XOPEN_SOURCE&quot; redefined
   19 | #define _XOPEN_SOURCE
      | 
&lt;command-line&gt;: note: this is the location of the previous definition
volume_mapping.c: In function &apos;get_normalized_volume&apos;:
volume_mapping.c:116:15: warning: implicit declaration of function &apos;exp10&apos; [-Wimplicit-function-declaration]
  116 |  normalized = exp10((value - max) / 6000.0);
      |               ^~~~~
volume_mapping.c:116:15: warning: incompatible implicit declaration of built-in function &apos;exp10&apos;
volume_mapping.c: In function &apos;set_normalized_volume&apos;:
volume_mapping.c:151:14: warning: incompatible implicit declaration of built-in function &apos;exp10&apos;
  151 |   min_norm = exp10((min - max) / 6000.0);
      |              ^~~~~
../alsamixer/volume_mapping.c: In function &apos;get_normalized_volume&apos;:
../alsamixer/volume_mapping.c:116:15: warning: implicit declaration of function &apos;exp10&apos; [-Wimplicit-function-declaration]
  116 |  normalized = exp10((value - max) / 6000.0);
      |               ^~~~~
../alsamixer/volume_mapping.c:116:15: warning: incompatible implicit declaration of built-in function &apos;exp10&apos;
../alsamixer/volume_mapping.c: In function &apos;set_normalized_volume&apos;:
../alsamixer/volume_mapping.c:151:14: warning: incompatible implicit declaration of built-in function &apos;exp10&apos;
  151 |   min_norm = exp10((min - max) / 6000.0);
      |              ^~~~~
amidi.c: In function &apos;main&apos;:
amidi.c:692:5: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
  692 |     write(receive_file, buf, length);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alsaloop.c: In function &apos;parse_config&apos;:
alsaloop.c:398:6: warning: variable &apos;arg_effect&apos; set but not used [-Wunused-but-set-variable]
  398 |  int arg_effect = 0;
      |      ^~~~~~~~~~
aseqnet.c: In function &apos;flush_writebuf&apos;:
aseqnet.c:495:5: warning: ignoring return value of &apos;write&apos;, declared with attribute warn_unused_result [-Wunused-result]
  495 |     write(netfd[i], writebuf, cur_wrlen);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</pre>

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/17
Repository URL: https://github.com/alsa-project/alsa-utils
