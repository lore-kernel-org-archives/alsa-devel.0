From: Mario Moder <clay-man@arcor.de>
Subject: Strange noise at the beginning or the end of playback
Date: Sat, 5 Feb 2005 14:43:10 +0100
Message-ID: <20050205134310.GA1802@oddfellow.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Since I am using ALSA (I guess since 2 years) I have one and the same
problem with my Soundblaster Live Value. Right now I'm running kernel
2.6.10 with the included ALSA drivers. I have no asoundrc and no
complicated setup, all modules are running, all sound is playing
excellent, except...

When I play short wave files (less than 5 seconds), for example with
"aplay", I can hear one "click" or "pop" either at the very beginning
or the very end of the playback. No matter how often I repeat the
aplay command, the click/pop is always there, everytime I call "aplay"
with the same file. It is very disturbing especially at a high volume.
Longer files are played flawlessly. Here is what I have tried to get
it working:

- I played around with the --buffer-time option of aplay. Sometimes it
	worked but then some other files were heavily distorted. No
	solution.

- Tried all other options of "aplay". Changes could be heard but
	sometimes one file plays and the other not and with other settings
	the other way round.

- Used audacity to play the files. Worked perfectly but I cannot use
	audacity to play all my files (especially when called from
	applications on certain events). And AFAIK audacity still uses the
	oss-emulation of ALSA.

- Used audacity to add an additional silence (2-3 seconds) to the
	beginning and end of the file. After saving, the files played
	perfectly with "aplay" but adding silence to every short sound file
	is really no solution.

- Tried other players. "sox" sometimes worked, bplay mostly worked,
	xmms (but only when using OSS emulation output) played most of files
	perfectly. But I really need a commandline tool to play every short
	wave file perfectly not just most of them. --> No solution

- Made all possible sample format conversion... It is not a matter of
	format, it is just the length (< 5 sec) of the sample which makes
	the problem appear. No solution.

- Tried the emu10k1 OSS sound driver. Worked perfectly with all files
	but I really need ALSA --> No solution

- Tried Win2000. Worked perfectly but hey... That's no solution

- Played around with many many bios settings, enabled/disabled ACPI,
	PnP, etc. in BIOS, in kernel commandline... no solution

- Put the card in another PCI slot with another interrupt (btw, it
	does not share an interupt with another card). No solution.

Summary:

Files longer than 5 seconds: Everything works fine

Files shorter than 5 seconds: One loud click/pop at the beginning or
the end of playback

Since it works with old OSS and Windows I guess it is an ALSA driver
issue causing this behavior.

Searching the docs and the mailing list archives, I only found one
thread describing my problem but it also does not come to a solution:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10079.html

Does anybody know how to solve this issue? Or any other suggestions,
hints, tricks etc.?

Mario
 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
