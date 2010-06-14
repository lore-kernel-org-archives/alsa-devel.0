From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 12:03:22 +0100
Message-ID: <hv5289$i9l$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AB9DA10382D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 13:02:42 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OO7RB-0002KB-Ju
	for alsa-devel@alsa-project.org; Mon, 14 Jun 2010 13:02:41 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 13:02:41 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 13:02:41 +0200
In-Reply-To: <AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
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

'Twas brillig, and James Courtier-Dutton at 14/06/10 11:46 did gyre and
gimble:
> On 14 June 2010 11:22, Colin Guthrie <gmane@colin.guthr.ie> wrote:
>> 'Twas brillig, and James Courtier-Dutton at 14/06/10 09:56 did gyre and
>> gimble:
>>> If you use "alsamixer", dB values are shown so it is easy to find the
>>> 0dB "sweet spot".
>>> I think it is pulse audio that hides this information when it combines
>>> two alsa mixer controls into one pulseaudio control.
>>
>> But it doesn't hide it. It's shown very clearly in the volume control
>> GUIs as the Base Volume.
>>
>> Do you really think that most users look at the sliders to find the 0dB
>> point? Does gnome-alsa-mixer (the old one) expose this information? No.
>> Does kmix? No. So the vast, vast majority of users do not know where the
>> 0dB point is unless they use alsamixer.... and even if the user is
>> advanced enough to use alsamixer, then I'd still say a proportion of
>> users are just looking at how far up the slider is rather than looking
>> specifically for 0dB.
>>
>> So I'd argue the exact opposite of your claim. That with the base volume
>> clearly presented in the GUI, the h/w 0dB spot is much, much more
>> obvious to the vast majority of users.
>>
>> I really think this is a vast improvement over a complex balancing act
>> of getting two different sliders setup to get distortion free audio!
>>
>> Col
> 
> One has very different problems with capture than one does with playback.
> With capture it is important to identify which are analog controls
> (applied to the analog part of the circuit) and which are digital
> controls (applied to the digital part of the circuit)
> So, for capture one might wish to adjust the analog control so that
> the signal going into the ADC is a suitable level, but once the signal
> is digital, one should really not adjust it further, and just record
> what you have.
> If one was to combine these two capture controls in one PA control, it
> would just be wrong.
> 
> I think there is some indication with the name of the control. It
> sometimes has "Analog" or "Digital" attached to it.
> I think this would be better if alsa reported the "Analog" or
> "Digital" as meta data, like the dB Scales.
> PA could then make more informed decisions for capture. I.e. only
> display the "Analog" controls, and hide the digital ones, setting them
> to 0dB.
> That would provide the most distortion free capture.
> I think it would also be useful if the alsa driver also reported meta
> data indicating how the controls are connected together, because then
> PA would have even more information to make better decisions.
> For example, USB audio devices have this information, but it is not
> sent to user space.


Sounds like that would actually fit in with the current logic (correct
me if I'm wrong). PA adjusts multiple sliders in a left-to-right
fashion, trying to achieve the ultimate volume the user has requested by
setting the left most first and checking if it's "accurate enough". If
it is, then it stops there, but if not then it tries to adjust the
control to the right. This is repeated until we are "accurate enough"
with any further adjustements made in software if needed.

If all the analog controls are lined up to the left followed by all the
digital controls to the right, then the goal of "leaving the digital
controls alone if at all possible" would be a by product (I think).

At present Master will always be left most, and PCM will always sit to
the right of it.

In addition to Lennart's previously posted link on Volume Control GUIs
(for the lazyweb: http://pulseaudio.org/wiki/WritingVolumeControlUIs),
this approach is explained here:
http://pulseaudio.org/wiki/PulseAudioStoleMyVolumes


Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
