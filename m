From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [RFC 03/12] ASoC: Consolidate use of controls with
	custom get/put function
Date: Tue, 4 Oct 2011 19:36:36 +0300
Message-ID: <CAPo=G1wuq1wH6d8zS9DdVN0dXa=Tajkc65cKGig2yQ2_XBqxqA@mail.gmail.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-4-git-send-email-peter.ujfalusi@ti.com>
	<20111004153054.GM6934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 24BCC10388B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 18:36:37 +0200 (CEST)
Received: by mail-gy0-f182.google.com with SMTP id 2so849370gyf.13
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 09:36:37 -0700 (PDT)
In-Reply-To: <20111004153054.GM6934@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 4, 2011 at 6:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 04, 2011 at 02:39:40PM +0300, Peter Ujfalusi wrote:
>> Use the macros for controls require custom get/put function.
>> This is to make sure that the soc_mixer_control is used
>> consistently among the drivers.
>
> Hrm, this doesn't actually apply on for-3.2 - looks like it collides
> with Axel's cleanups. =A0Can you check and regenerate please?

Sure.

-- =

P=E9ter
