From: "Rene Dohmen" <acidjunk@gmail.com>
Subject: no front speaker sound with ALC262
Date: Sat, 23 Feb 2008 01:45:08 +0100
Message-ID: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AAFCA2458D
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:45:09 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so421753fgb.44
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 16:45:09 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear List,

I have a problem with an Intel HDA soundcard
lspci output:
-----
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)

The sound volume is very very low when i use the headphone output. The
device has integrated speakers but i don't hear any sound coming out of them
(maybe because the volume is so low...). I've put all the mixer channels to
the maximum values. When booted in Win XP the soundcard works correctly.

Is see one line in my logs that indicate that something is wrong: hda_codec:
Unknown model for ALC262, trying auto-probe from BIOS...

I didn't have it working with other versions of ALSA.  Tested with
1.0.14(provided with ubunty gutsy), then started reading, lots of
suggestions
stated that the problem would be solved in 1.0.15, so i compiled 1.0.16 from
src and replaced the default alsa modules with the new ones.

De device i 'm using is supplied by tangent (
http://www.tangent.com/t_all_in_one_LCDPC/vita_8000s.htm) its an all in one
solution with touchscreen and speakers integrated in one small cabinet.

I runned the alsa-info.sh script output and uploaded it:
http://pastebin.ca/913865

I don't know if this is the correct place for getting help but all help is
appreciated,

Best Regards,
Rene Dohmen
