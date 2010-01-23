From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Echo Indigo card on Sabayon Gentoo
Date: Sat, 23 Jan 2010 10:33:42 +0100
Message-ID: <20100123103342.26f5e564@Jay>
References: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
	<20100117230438.33ca6692@Jay>
	<152312.48176.qm@web65610.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-OUT05A.alice.it (smtp-OUT05A.alice.it [85.33.3.5])
	by alsa0.perex.cz (Postfix) with ESMTP id B5A8A1037FC
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 10:34:24 +0100 (CET)
In-Reply-To: <152312.48176.qm@web65610.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Jan 2010 23:15:41 -0800 (PST)
"S. Aguinaga" <sa_jr@yahoo.com> wrote:

> No luck, same behavior. I edited the first file listed listed below and recompiled it and installed it.
> Then I restarted the system with the indigo card in place, and the VU meters show levels in the -120 to -100 dB?

I did some tests with my indigoIOx. I added the "#define
ECHOCARD_HAS_LINE_OUT_GAIN" in indigoiox.c and it compiled and loaded fine.
That change adds this control to the set (which does not work on my card):

numid=17,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=-128,max=6,step=0
  : values=-128,-128
  | dBscale-min=-128.00dB,step=1.00dB,mute=1

Please check it exists with "amixer -c <cardnumber> contents" (your numid
may differ). If it doesn't, you didn't patch indigoio.c correctly. That
control is not supposed to exist in Indigo and Mia cards, but since in the
Mia it does, it might be there in the CARDBUS indigos as well.

Please use a recent echomixer and make sure the values of the control above
are not -128dB.


-- 
Giuliano.
