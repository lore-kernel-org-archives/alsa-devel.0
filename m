From: "Dr. Alexander K. Seewald" <alex@seewald.at>
Subject: Status of Dolby Digital on-the-fly encoding? (via a52
	plugin)
Date: Tue, 11 Dec 2007 14:22:49 +0100
Message-ID: <20071211132249.GA12802@sdg.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seewald.at (seewald.at [213.208.134.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C7A1244A4
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 14:23:19 +0100 (CET)
Received: from alexsee by athlon64.sdg.at with local (Exim 4.52)
	id 1J254T-0003MI-P2
	for alsa-devel@alsa-project.org; Tue, 11 Dec 2007 14:22:49 +0100
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

I am trying to output Dolby Digital data via coaxial cable to the
Logitech Z-5450 5.1 speaker set. Presumably, a52 is the right plugin
for this, taking six channels and combining them into the right
format. However, I cannot seem to make the Z-5450 understand the
format... it always displays "No digital data" and does not output
anything.

Now, the documentation is very sparse on this, but states that
Dolby Digital is supported, as well as DTS and DTS with 96kHz
sampling rate and 24bit samples. The Z-5450 can play digital PCM
stereo data, but this only activates left and right speaker (it is
possible to set an effect to distribute sound to the other speakers,
but this is insufficient for my purpose). I can play digital DVD
5.1 sound by attaching the coaxial cable to a DVD player.

As of now, speakertest -c 6 tries to play sound on all speakers, but
only left and right respond. For all other speakers, "No digital data"
is displayed on the Z-5450 console. This is consistent with the Z-5450
not able to play six-channel PCM data. However, using -Dplug:a52 and
.asoundrc =

pcm.a52 {
  type a52
}
(with various settings)

always shows "No digital data" and no sound output. I had a sample
DTS 96/24 file a while ago which was able to activate all speakers,
so the data connection is ok. But sadly I have misplaced it; in any
case DTS 96/24 support is not what I'd expect in the near future.

Has anyone successfully output Dolby Digital (A52, AC3, ..) data via
coax to the Z-5450 or a similar model? I'm using the newest alsa
drivers and plugins on an 2.6.11, and the stereo-PCM output has been
working for years... but this one keeps bugging me.

Best,
  Alex
-- 
Dr. Alexander K. Seewald         +43(664)1106886
              Seewald Solutions                 
------------------------------------------------
         Information wants to be free;
Information also wants to be expensive (S.Brant)
--------------- alex.seewald.at ----------------
