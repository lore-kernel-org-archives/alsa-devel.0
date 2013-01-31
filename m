From: Harald Sitter <sitter@kde.org>
Subject: crashes in namehint
Date: Thu, 31 Jan 2013 17:06:56 +0100
Message-ID: <CAEc+18GnWriRtYnd+u5hiQ7OpcAytp1hakhbdZjYVzxcdTFwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0453C2602F7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 17:07:18 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id hz10so1791449pad.37
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 08:07:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, colin@mageia.org, Martin Sandsmark <sandsmark@samfundet.no>
List-Id: alsa-devel@alsa-project.org

aloha,

I am working on kde multimedia and we are getting a considerable amount of
crash reports from x86 ubuntu and fedora users.

https://bugs.kde.org/show_bug.cgi?id=268185
http://notes.kde.org/alsa-bugs

these crashes appear to be somewhat limited to x86 with only about 2
reports seeing this happen on x86_64. most of the reports suggest that it
happens at startup and in particular for applications that tend to query
ALSA devices shortly after startup (in fact, out of main() via a direct
call chain). there are 3 different reports of which a sigsev in strcpy and
sprintf seem most concerning. both appear in try_config() which was called
with a malformed `name` string.

now at least the sprintf and the strcpy crashes I can somewhat reliably
reproduce on kubuntu 12.10 x86 in a virtualbox vm using the command
'kcmshell4 phonon' with phonon-backend-vlc installed and selected as
default.
and it appears that those are somehow related to how ubuntu does the
pulseaudio integration...

in /usr/share/alsa/alsa.conf all of alsa.conf.d/* is included, then there
is alsa.conf.d/pulse.conf which contains

> hook_func.pulse_load_if_running {
>  lib "libasound_module_conf_pulse.so"
>  func "conf_pulse_hook_load_if_running"
> }
>
> @hooks [
>  {
>  func pulse_load_if_running
>  files [
>  "/usr/share/alsa/pulse-alsa.conf"
>  ]
>  errors false
>  }
> ]

so they load /usr/share/alsa/pulse-alsa.conf after checking PA is running.
that file in turn contains the default pulse setup as seen in alsa-plugins
[1]

now with that lineup I can crash the kcmshell binary about 9/10 times with
the strcpy sigsev where name in try_config is 0.
if I replace the conditional load in pulse.conf with an explicit one (func
load) it crashes about half as often but with the sprintf sigsev in
try_config (name now being out-of-bounds rather than 0). if the content of
pulse-alsa.conf (i.e. the actual config) is copied into pulse.conf the
binary does not crash *at all*.

quite the mysterious problem. however, since the crash disappears entirely
when removing the second load (i.e. instead of
alsa.conf->alsa.conf.d/pulse.conf->pulse-alsa.conf one were to use
alsa.conf->alsa.conf.d/pulse.conf), I am lead to believe that this is
either a problem caused by the second level of loading in general or a
timing problem at large. most likely it is a combination of both where the
additional load() calls introduce sufficient overhead to trigger the timing
problem.

ideas/thoughts/fixes welcome :S

HS


[1]
http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/99-pulseaudio-default.conf.example;h=4f5885806898a76f5a5c9b3ec76b804fe54e2480;hb=HEAD
