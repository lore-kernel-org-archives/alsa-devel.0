From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-user] ALSA Newbie - Getting Ensoniq
 SoundscapeVivo to work?
Date: Sun, 29 Apr 2007 09:33:23 +0200
Message-ID: <46344A43.8000203@gmail.com>
References: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>	
	<463319CA.4040309@gmail.com> <4633356F.9090404@opensound.com>	
	<4633CD22.9070305@gmail.com>
	<d382e1990704281918g42165aaas4cac717fe5b4bab0@mail.gmail.com>
	<463449E0.70909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000003020304010001020702"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <463449E0.70909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cody Jung <funkycat32@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000003020304010001020702
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 04/29/2007 09:31 AM, Rene Herman wrote:

> I've attached (to try and avoid linewrap) the lines that you will need in
> /etc/modprobe.conf.

No I haven't.

Rene.

--------------000003020304010001020702
Content-Type: text/plain;
 name="modprobe.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprobe.conf"

alias		snd-card-0	snd-cs4231
alias		sound-slot-0	snd-cs4231

options		snd-cs4231	index=0 port=0x534 irq=5 dma1=1 dma2=0

install		snd-cs4231	echo activate >/sys/bus/pnp/devices/01\:01.00/resources &&\
				sleep 1 &&\
				/sbin/modprobe --ignore-install snd-cs4231

remove		snd-cs4231	/sbin/modprobe -r --ignore-remove snd-cs4231 &&\
				echo disable >/sys/bus/pnp/devices/01\:01.00/resources

--------------000003020304010001020702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000003020304010001020702--
