From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Separate default devices for playback and capture
Date: Wed, 19 Sep 2007 08:53:04 +0200
Message-ID: <1190184784.24874.1211415353@webmail.messagingengine.com>
References: <46F07024.5040903@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 01F092444A
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 08:53:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46F07024.5040903@trn.iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Lasse=20K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lasse K=E4rkk=E4inen wrote:
> I've been reading the library source code and from what I gather, it
> seems that it just fundamentally cannot support separate config sections
> for playback and capture.

For PCM devices, you can use the asym plugin.


HTH
Clemens
