From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 7/8] ALSA: VIA HDA: Get codec's type
 in	via_new_spec() function
Date: Tue, 22 Mar 2011 12:15:33 +0530
Message-ID: <4D88458D.2060505@st.com>
References: <4D8842DD.4040600@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 286DC103826
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:48:10 +0100 (CET)
In-Reply-To: <4D8842DD.4040600@viatech.com.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lydia Wang <lydiawang@viatech.com.cn>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "HaraldWelte@viatech.com" <HaraldWelte@viatech.com>
List-Id: alsa-devel@alsa-project.org

Lydia
On 3/22/2011 12:04 PM, Lydia Wang wrote:
> spec->codec_type=B7=3D=B7get_codec_type(codec);
> =BB       /*=B7VT1708BCE=B7&=B7VT1708S=B7are=B7almost=B7same=B7*/
> =BB       if=B7(spec->codec_type=B7=3D=3D=B7VT1708BCE)
> =BB       =BB       spec->codec_type=B7=3D=B7VT1708S;

Why you need to do this.Are you doing any specific work related to  VT1708S.
I think in call cases your codec_type is VT1708S.

Best Rgds
Rajeev
