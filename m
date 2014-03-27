From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ASoC: davinci-mcasp: set up channel
 status bits for S/PDIF mode
Date: Thu, 27 Mar 2014 11:26:36 +0100
Message-ID: <5333FCDC.3070809@gmail.com>
References: <1395913744-29720-1-git-send-email-zonque@gmail.com>
 <5333F5E8.8080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 92DC526525B
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 11:26:51 +0100 (CET)
Received: by mail-bk0-f49.google.com with SMTP id my13so743109bkb.22
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 03:26:51 -0700 (PDT)
In-Reply-To: <5333F5E8.8080506@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On 03/27/2014 10:56 AM, Peter Ujfalusi wrote:
> On 03/27/2014 11:49 AM, Daniel Mack wrote:

>> +	u32 val = 0;
>> +	u8 *bytes = (u8*) &val;
> 
> Would it be better to call these variables as:
> u32 cs; /* as in Channel Status */
> u8 *cs_bytes = (u8*) &cs; /* Channel Status in bytes */
> 
> Without the comments of course.
> Sorry, I did not noticed this previously...

No problem. v3 coming up.

> Otherwise it looks good, does it work? ;)

It does! :)


Daniel
