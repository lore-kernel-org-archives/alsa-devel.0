From: Petr Kulhavy <brain@jikos.cz>
Subject: Set multiple mixer channel values at once
Date: Mon, 8 Jan 2018 12:01:34 +0100
Message-ID: <35d6971a-efcf-443d-b25e-dc448780e492@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twin.jikos.cz (twin.jikos.cz [91.219.245.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 5362326698E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 12:01:40 +0100 (CET)
Received: from [192.168.100.123] (240.90.254.84.ftth.as8758.net
 [84.254.90.240]) (authenticated bits=0)
 by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w08B1dbC007375
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Mon, 8 Jan 2018 12:01:40 +0100
Content-Language: de-CH
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

does the ALSA library provide a method to set multiple channel values of =

a multi-channel mixer element at once? There are the =

snd_mixer_selem_set_XXXXX_all()=A0 methods, which set all channels to the =

same value.
I would like to write a different value to each channel, is there such a =

method?

My motivation is the following. I have a HW with DSP/equaliser function, =

which uses a 5-channel mixer element (volume type element) to store =

biquad coefficients.
To avoid invalid values in the transfer function the coefficients have =

to be sent to the HW over I2C all together in one transfer. Though the =

low level driver does that, the snd_mixer_selem_set_playback_volume() =

API method I'm using sets only one coef at a time.
This results in partial updates of the biquad coefficients and temporary =

errors in the transfer function.

Thanks
Petr
