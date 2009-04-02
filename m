From: Singaravelan Nallasellan <singaravelann@hotmail.com>
Subject: Re: Interleaving and Deinterleaving support
Date: Thu, 2 Apr 2009 17:11:48 +0000
Message-ID: <BAY119-W561BDECA5454D3CB424F0DB0880@phx.gbl>
References: <BAY119-W55D505978A73AE7CDB81D4B08B0@phx.gbl>
	<49D4DACA.2010308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc1-s36.bay0.hotmail.com (bay0-omc1-s36.bay0.hotmail.com
	[65.54.246.108])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF25103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 19:11:49 +0200 (CEST)
In-Reply-To: <49D4DACA.2010308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Clemens,

 =


Thanks for the information. It really helps.
 =

> Date: Thu, 2 Apr 2009 17:33:30 +0200
> From: clemens@ladisch.de
> To: singaravelann@hotmail.com
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Interleaving and Deinterleaving support
> =

> Singaravelan Nallasellan wrote:
> > Does alsa core in the kernel support interleaving and deinterleaving?
> =

> No, but the alsa-lib plugins can do this.
> =

> > if the driver receives a deinterleaved stream and wants to interleave
> > for the sound card, should the driver perform the conversion?
> =

> No, the driver should just set the bit that indicates that the hardware
> supports interleaved data; the data will then be automatically
> converted by alsa-lib.
> =

> =

> HTH
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

_________________________________________________________________
Rediscover Hotmail=AE: Now available on your iPhone or BlackBerry
http://windowslive.com/RediscoverHotmail?ocid=3DTXT_TAGLM_WL_HM_Rediscover_=
Mobile1_042009
