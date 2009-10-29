From: Shawn Starr <shawn.starr@rogers.com>
Subject: Conexant CX20561 - Microphone problems
Date: Thu, 29 Oct 2009 18:59:40 -0400
Message-ID: <200910291859.41076.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.rog.mail.re2.yahoo.com (smtp108.rog.mail.re2.yahoo.com
	[68.142.225.206])
	by alsa0.perex.cz (Postfix) with SMTP id 1D076103826
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 23:59:45 +0100 (CET)
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

Hello ALSA developers, 

I am having problems with the microphone on the following hardware this is on 
a Lenovo W500 laptop.

Card: HDA Intel                                                                                   
Chip: Conexant CX20561 (Hermosa)

Here is the problems im noticing:

1) If I use ALSA 'default' with the microphone I get noise interference on 
output [high/low/high/low]. 

If I switch this to use the "ALSA Capture on HDA Intel [CONEXANT Analog] I get 
interference except it is the standard 60Hz electrical noise [steady noise]

2) Using the internal/external microphones gives an inconsistent volume. It 
also does not seem to work with the microphone cutting out so much. I need to 
adjust Digital + another microphone but it still drops capturing.

Alsamixer shows:  Digital/Docking Microphone/External Microphone/Internal 
Microphone

Here is the module options I give to the sound driver:

options snd-intel-hda enable_msi=1 power_save=10 power_save_controller=true 
model=laptop index=0

Assuming power saving/controller causes the microphone to cut out or not.

3) I'm now aware that this card has no pinouts for PCM capture 
https://bugzilla.redhat.com/show_bug.cgi?id=502293

Thanks for any help, 
Shawn.
