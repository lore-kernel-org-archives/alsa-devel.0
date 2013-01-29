From: =?iso-8859-1?Q?J=E9r=F4me_Forissier?= <jerome@taodyne.com>
Subject: Thread safety of snd_pcm_open?
Date: Tue, 29 Jan 2013 20:15:13 +0100
Message-ID: <23152B82-AC4E-4F64-9F70-43866D910A0F@taodyne.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 284F3261689
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 20:15:23 +0100 (CET)
Received: by mail-wi0-f181.google.com with SMTP id c10so798853wiw.14
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 11:15:15 -0800 (PST)
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

Hello,

I'm having problems using ALSA with LibVLC.
The project page http://www.alsa-project.org/main/index.php/SMP_Design claims that the snd_*_open() calls are thread safe, yet it seems that when LibVLC calls them from several threads it can lead to errors like:
ALSA lib conf.c:4571:(parse_args) Unknown parameter CARD
ALSA lib conf.c:4571:(parse_args) Unknown parameter DEV
ALSA lib conf.c:4704:(snd_config_expand) Parse arguments error: No such file or directory
ALSA lib conf.c:4687:(snd_config_expand) Unknown parameters CARD=NVidia,DEV=0
ALSA lib conf.c:4571:(parse_args) Unknown parameter CARD
ALSA lib conf.c:4687:(snd_config_expand) Unknown parameters CARD=PCH,DEV=0
ALSA lib conf.c:4687:(snd_config_expand) Unknown parameters CARD=NVidia,DEV=0
ALSA lib conf.c:4571:(parse_args) Unknown parameter DEV
(Please see http://mailman.videolan.org/pipermail/vlc-devel/2013-January/091603.html and also http://mailman.videolan.org/pipermail/vlc-devel/2013-January/091633.html for a reproducer on top of LibVLC).

I'm not familiar with the internals of ALSA lib, nor with the internals of LibVLC. The VLC devs claim that they respect the rules regarding ALSA access, but I can't tell for sure...

I'm currently running my reproducer with valgrind, but before I dig too deeply, could you please give some advice?

I have noticed that pcm_direct.c calls getgrnam() which is not reentrant (but replacing it with getgrnam_r is not enough to fix my problem).
Also there does not seem to be any locking around snd_pcm_open[_noupdate]. Are those functions supposed to be reentrant?

Thanks for your help,

-- 
Jerome
