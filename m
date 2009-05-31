From: renidragsemaj@yahoo.com
Subject: Recent breakages (was:  (no subject))
Date: Sat, 30 May 2009 23:57:59 -0700 (PDT)
Message-ID: <829874.32198.qm@web54503.mail.re2.yahoo.com>
Reply-To: renidragsemaj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web54503.mail.re2.yahoo.com (web54503.mail.re2.yahoo.com
	[206.190.49.153]) by alsa0.perex.cz (Postfix) with SMTP id 3898924389
	for <alsa-devel@alsa-project.org>;
	Sun, 31 May 2009 08:58:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: renidragsemaj@yahoo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--- On Sat, 5/30/09, Takashi Iwai <tiwai@suse.de> wrote:

>> Hi, someone recently submitted changes to the patch_sigmatel.c codec
>> source. Whatever was done is breaking my patch for the HP dv4-1222nr
>> laptop. I also strongly suspect that other code in the stac92hd71bxx
>> function has been affected. There is no autodetect, there is no
>> option for modprobe that will load that codec currently, to the best
>> of my knowledge. I've tracked the difference to snapshot
>> 20090529. Before that, I can get it to work, there and after refuses
>> to work properly.
>
>Could you try to copy hda_intel.c from 1.0.20 and check whether this
>fixes the problem?=A0 Most likely I broke something.

You seem to have that right. I changed out that file like you said and it w=
ent back to working. Now, only to find out what happened...

>>
>> Also, there was a recent change to the
>> stac92xx_hp_check_power_status function: While the change looks good
>> for its intended purpose of localizing board changes to the
>> switch/case statements in the stac92hd71bxx function, the
>> implementor reversed the if/then selector: =

>
>Fixed now.=A0 Thanks for checking!

Thank you. It seems that I had two big booboos with this part of my post. 1=
) Sorry about all those question marks: It looks like my cut and paste job =
didn't go the way I planned. 2) I messed up and switched the old and new co=
de in my post, but it looks like you caught my screw-up. The recent snapsho=
t (20090531) has it right. *Don't change it back!* :)

Thank you,
James Gardiner



      =
