From: boku <boku0712@gmail.com>
Subject: Re: Fwd: memory allocate for substream->runtime->dma_area
Date: Fri, 17 Mar 2006 11:26:49 +0800
Message-ID: <715d90900603161926y2d8d47e5k92f363011b5ccda6@mail.gmail.com>
References: <715d90900603141942y6c409027sb5a99be13f5ec462@mail.gmail.com>
	 <715d90900603141943h423c0ffdydedec3f1ed50a375@mail.gmail.com>
	 <1142394842.24603.77.camel@mindpipe>
	 <715d90900603142003jd1b1d00he8daf7331cc72237@mail.gmail.com>
	 <1142454177.1671.38.camel@mindpipe>
	 <715d90900603151909o6bb834efv401392e5239a0435@mail.gmail.com>
	 <715d90900603152107q30b76a85l4b428167d515ee8c@mail.gmail.com>
	 <715d90900603152121t40c2c5ddg4e6bce9df9f6e5a9@mail.gmail.com>
	 <441A06A4.7030100@kenati.com> <1142558258.9395.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3637_30047812.1142566009041"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142558258.9395.34.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_3637_30047812.1142566009041
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

About the dedicated DMA space, if I use ioremap to set the DMA address spac=
e
and assign runtime->dma_area point to it, all the data access within the
address space must use ioread/write instead of direct dereference. What
should I do in this case?  Thanks!~

BR,

------=_Part_3637_30047812.1142566009041
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>About the dedicated&nbsp;DMA space, if I use ioremap to set the DMA ad=
dress space and assign runtime-&gt;dma_area point to it, all the data acces=
s within the address space must use ioread/write instead of direct derefere=
nce. What should I do in this case?&nbsp; Thanks!~
</div>
<div>&nbsp;</div>
<div>BR,</div>
<div>&nbsp;</div>

------=_Part_3637_30047812.1142566009041--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
