From: Jaakko =?iso-8859-1?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: Hammerfall DSP System Problems
Date: Thu, 12 Jun 2003 14:28:47 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306121428.47708.Jaakko.Prattala@Helsinki.FI>
References: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net> <Pine.LNX.4.53.0306120009030.1274@pi32.pi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0306120009030.1274@pi32.pi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>, Paul Davis <paul@linuxaudiosystems.com>
Cc: D R Holsbeck <drh@niptron.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thursday 12 June 2003 08:13, Jesse Chappell wrote:
> Hwdep ioctl error on card hw:0 : Input/output error.
[...]
>  ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644:
>     wait for FIFO status <=3D 127 failed after 5000 iterations
> causing the function to return -EIO hence the ioctl error passed
> back to hdsploader.

This is exactly what I'm seeing on my hp xe4100
(with multiface+cardbus). Thank you Jesse for your explanation.

> If there is any offlist discussion about the HDSP debugging,
> please include me in those messages.

Yes, please, me too.

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
