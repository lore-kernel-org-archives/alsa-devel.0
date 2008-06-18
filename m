From: "=?ISO-8859-1?Q?Andreas_P=E5hlsson?=" <andreas@pahlsson.info>
Subject: Re: Avoid overload of PCM volume on Cx5045 codec
Date: Wed, 18 Jun 2008 21:58:40 +0200
Message-ID: <fff10a40806181258t20e5c5f5rfd9fc234a91770d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id CE79710380B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 21:58:42 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so5131755rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 12:58:41 -0700 (PDT)
Content-Disposition: inline
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

Hello.

I've had a problem with low volume on my laptop and while scratching
this itch I found the patch titled "hda-codec - Avoid overload of PCM
volume on Cx5045 codec" I reverted this patch and of course got a lot
more volume. The description states: "The PCM volume of Cx5045 codec
has overload that isn't useful but rather harmful.  Add a hack to
override the amp info to set the max level 0 dB.". Does anybody know
where to find more information on a better default value for the max
level setting?


regards,

Andreas P=E5hlsson
