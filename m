From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Multiple codecs on the same DAI
Date: Thu, 23 Nov 2017 15:51:19 +0100
Message-ID: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C3427266B02
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 15:51:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,

I'm studying a hardware implementation where an S/PDIF receiver is on the =

same I2S connection as codec. Essentially, the S/PDIF receiver echos the =

I2S capture data from the codec unless there is a digital input signal =

which it can lock on to. For playback, the I2S output from the CPU DAI =

goes directly to the codec.

I'm a bit at a loss for how to model this in ALSA. I know it's possible to =

have multiple codecs on a card, but those cases seem to be either separate =

codecs for the left and right channels, or separate codecs for capture and =

playback. In my case the playback codec is always the same, but the =

capture codec can switch between the two avilable input methods (more or =

less automatically if the S/PDIF receiver is so configured).

>From a user perspective, it's not important that ALSA knows where the data =

is actually coming from, so if I could just register the two "codecs" on =

the same dai_link at the same time it would be fine, but I'm just =

imagining that I'll run into problems when ALSA tries to set up streams =

with two different codecs being involved. (Of course, at some level, the =

user might be interested to know the signal routing, but that can be =

determined by reading appropriate status bits in the S/PDIF receiver for =

instance using amixer controls).

Do you have any ideas about how to configure this in ALSA?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
