From: Florian <golf.iii.aberdeen@gmx.co.uk>
Subject: pls help to debug / patch ALC861 on Uniwill L51RI
Date: Sun, 10 Apr 2011 08:51:53 +0000 (UTC)
Message-ID: <loom.20110410T104313-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7496F24477
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Apr 2011 10:55:13 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Q8qQC-0006JU-S9
	for alsa-devel@alsa-project.org; Sun, 10 Apr 2011 10:55:05 +0200
Received: from 194-105-169-26.ifb.co.uk ([194.105.169.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2011 10:55:04 +0200
Received: from golf.iii.aberdeen by 194-105-169-26.ifb.co.uk with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2011 10:55:04 +0200
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

I have a laptop (Uniwill L51RI [Gericom Hollywood Advance]) with HDA ALC861.
On initial installation of Ubuntu (any from 8.x - to 10.10) sound output works
with ALSA without problem, input not at all.
I have managed to get the microphone sound (int. or ext. can't remember) played
back via speakers using HDA-Analyzer,
not managed to get it to record etc.

My plan:
>From a clean install (preferable Ubuntu 10.10 or 11.04) compile newest ALSA;
then what are the first steps to do to be able to trace my steps and to get
support here or somewhere else?
Who can help me to debug the whole thing and make it available for everyone?
Where should I put output from alsa-info.sh, who can help me make a new model
for snd-hda-intel module?
How do I use the codecgraph?

(I'm happy to get some direct links for specific pages, however, I gave up on
google, followed everything I could find. Most sensible seems to me try
HDA-Analyzer together with someone who can help me get a bit further [if I get
mic sound to output, how do I get it to record etc.])

UPDATE:
Currently I use Ubuntu 10.10 32bit, with HDA Analyzer I managed to play around a
lot and can output the mic-input (int+ext) directly to speakers and headphones,
however, I cannot find a way to send it to any software/make it available.
in the standard gnome audio capture software (forgot the name) I can record
software output (eg. mp3's) when i switch the used audio device to "Analog
Output" and then back to "Analog Duplex" (then nothing is selected in capture
device - the moment I select the only available device, "mic", there is nothing
to be captured any more).

any hints, advice?
