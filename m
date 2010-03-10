From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 20/20] ASoC: SMDK64XX: Switch to IISv4 CPU
	driver
Date: Wed, 10 Mar 2010 22:05:47 +0900
Message-ID: <1b68c6791003100505nf0dcddbtd8ed0c7fa395cb91@mail.gmail.com>
References: <1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-13-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-14-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-15-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-16-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-17-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-18-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-19-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-20-git-send-email-jassi.brar@samsung.com>
	<20100310114003.GK24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id D13D310396C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:05:48 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so478007qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 05:05:48 -0800 (PST)
In-Reply-To: <20100310114003.GK24422@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 8:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 10, 2010 at 04:49:09PM +0900, Jassi Brar wrote:
>> Switch the MACHINE driver to use IISv4 CPU dai.
>> Remove BROKEN dependency now that we have proper CPU driver available.
>> Also, disable build for SMDK6400, since the S3C6400 doesn't have IISv4
>> controller.
>
> Will the driver actually probe with mainline?
Need to check.
