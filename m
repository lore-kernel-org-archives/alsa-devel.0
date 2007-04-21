From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: No sound with ATI SB450
Date: Sat, 21 Apr 2007 14:56:34 +1000
Message-ID: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_158014_23212278.1177131394138"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 4656D246AC
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2007 06:56:35 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1120445anc
	for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2007 21:56:34 -0700 (PDT)
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

------=_Part_158014_23212278.1177131394138
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
I have a toshiba A100 (see attached file lspci-nnv) with a ATI SB450.
Sound worked fine with kernel 2.6.17 and alsa 1.0.12rc1 (ubuntu edgy).
I just did a fresh install of ubuntu feisty (kernel 2.6.20, alsa
1.0.14rc1) and the only mixer settings available are those of the
modem, named off-hook and caller-id (see output of amixer, aplay -l ,
and the rest in attached file output_feisty)

I decided to upgrade alsa-driver and alsa-lib to 1.0.14rc2. after
downloading the package, I unloaded all sound related modules
(everything with "snd_" in it) in the right order and did:
./configure --with-oss=yes --with-cards=hda-intel;make; sudo make
install; sudo modprobe snd_hda_intel
A minor improvement: the mixer now shows controls for both the modem
and the sound card (see output_after_upgrade_to_rc2), but
unfortunately, there is still no sound coming out of those speakers
(even though alsamixer shows control for PCM and the rest...).

Finally, I downloaded alsa-driver-1.0.14rc3 and gave it a shot. This
time again, only modem related settings appeared in alsamixer, and no
sound card stuff (see aplay and amixer in
output_after_upgrade_to_rc3), and no sound either.

Does anyone know how to get some sound out of these speakers (given
that it used to work with alsa1.0.12rc1...) ?

Thanks for your help
Ben

------=_Part_158014_23212278.1177131394138
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_158014_23212278.1177131394138--
