From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: [RFC] Standard for Multichannel Mixer Control Names
Date: Sat, 17 Mar 2007 17:51:54 -0400
Message-ID: <45FC62FA.5080403@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by alsa0.perex.cz (Postfix) with ESMTP id D117D24460
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2007 22:52:05 +0100 (CET)
Received: from [127.0.0.1] (really [67.20.25.133]) by mta11.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20070317215203.XPDV2195.mta11.adelphia.net@[127.0.0.1]>
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2007 17:52:03 -0400
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In an exchange with Takashi regarding my proposal for changing some 
mixer control names, he recommended that I start a thread in attempt to 
reach consensus regarding a convention/standard for mixer control names 
in ALSA.

My name-changing effort was complicated by the fact that, as Takashi put 
it:  "Many apps assume either 'Master' or 'PCM' mixer exists."

(Background:  The only multichannel audio adapter to which I have access 
for testing is an Analog Devices AD1986A CODEC attached to an AC '97 
chipset on a motherboard.)

In desiring to rename controls, I assumed that the AC '97 multichannel 
driver control names represented an ALSA standard.  Actually I don't 
know how other drivers name their multichannel controls.  (The AC '97 
driver generically uses "Master" playback to control the front channel 
pin attenuation, and "PCM" playback to control multichannel DAC levels 
into the mixer.  "Surround", "Center" and "LFE" playback controls adjust 
pin attenuation for the respective channels.)

The AD1986/AD1986A CODECs are at variance with the AC '97 standard, 
causing "Master" playback to control pin attenuation for all channels, 
"PCM" playback to control only the front channel DAC levels, and 
"Surround", "Center" and "LFE" playback controls to affect DAC levels 
for their respective channels.  Hence my original reasoning that these 
control names are inappropriate.

(Other AD AC '97 multichannel CODECs are even less intuitive regarding 
their control usage, but in the interest of brevity I'll save that 
discussion for later.)

Questions:

What is the function of playback controls "Master" and "PCM" for 
multichannel CODECs driven by modules other than snd_ac97_codec?  Which 
control controls the front channels only, and which controls all 
channels?  What is the function of playback controls with names such as 
"Surround", "Center", and "LFE"?

Does ALSA need to standardize mixer control names, or should we continue 
to use whatever names are convenient for a given chipset/CODEC?  What 
standard should we use?

Randy Cushman



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
