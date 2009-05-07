From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: SNDRV_PCM_FORMAT_GSM
Date: Thu, 7 May 2009 20:07:41 +0530
Message-ID: <98769532B4BB14429434178695419EAE4AD52D6E@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE4AD52C07@bgsmsx501.gar.corp.intel.com>
	<20090507115244.GG27897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FACA1038B0
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 16:38:01 +0200 (CEST)
In-Reply-To: <20090507115244.GG27897@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you. That helps. 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk]
>Sent: Thursday, May 07, 2009 5:23 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] SNDRV_PCM_FORMAT_GSM
>
>On Thu, May 07, 2009 at 04:51:52PM +0530, Harsha, Priya wrote:
>
>> If I use the format SNDRV_PCM_FORMAT_GSM to identify if the audio
>> stream is voice stream or not, would it be appropriate?
>
>The format refers to the way the data is encoded rather than the meaning
>of the content - if actual GSM data were being transmitted it'd be
>sensible (but note that GSM format is not actually properly handled by
>ALSA yet).
