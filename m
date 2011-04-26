From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 1/4] davinci-mcasp: correct tdm_slots limit
Date: Tue, 26 Apr 2011 09:20:50 -0400
Message-ID: <BANLkTimPzok1VCefK1GtNaLM+Tg0nrR9=Q@mail.gmail.com>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
	<e6aa9fd05c44088ab8446f1c60d2056f92929483.1303408522.git.bengardiner@nanometrics.ca>
	<20110426104635.GA13252@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 6882C244AD
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 15:20:52 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id 14so689170bwz.2
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 06:20:50 -0700 (PDT)
In-Reply-To: <20110426104635.GA13252@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2011 at 6:46 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Apr 21, 2011 at 02:19:01PM -0400, Ben Gardiner wrote:
>> The current check for the number of tdm-slots specified by platform data=
 is
>> always true (x >=3D 2 || x <=3D 32); therefore the else branch that warn=
s of an
>> incorrect number of slots can never be taken.
>
> Applied all of these. =A0Please always try to ensure that your commit logs
> are consistent with the rest of the subsystem so they don't need to be
> rewritten.

Thanks, Mark, for taking the patches anyways (and Liam for the Ack's)
-- Sorry I forgot the 'ASoC' tag (I noticed this patch was committed
as 049cfaa ASoC: davinci-mcasp: correct tdm_slots limit).

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
