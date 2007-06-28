From: "Jose Henrique Spahn Torres" <jose.torres@eldorado.org.br>
Subject: sound on SMDK2410 working
Date: Thu, 28 Jun 2007 16:23:20 -0300
Message-ID: <AC2729D6E3A3314A922E4E0FBE513F65E46ECF@MAIL.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eldorado.org.br (mail.eldorado.org.br [200.168.210.67])
	by alsa0.perex.cz (Postfix) with SMTP id D42DE24461
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 21:23:23 +0200 (CEST)
Content-class: urn:content-classes:message
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

Hi all,

I was able to get sound on smdk2410 to work. I can play .wav files with
the following 
asound.conf file:

/etc $ more asound.conf
pcm.!default {
type hw
card 0
}

ctl.!default {
type hw
card 0
}


However the sound is distorted, in the sense that it sounds as played
with a lower rate.
I tried force a rate with -r 44100 or other rates, with no success.

Can anyone point me to the right direction?

Thanks,
Henrique
