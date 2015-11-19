From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Simple-card without codec for testing purpose
Date: Thu, 19 Nov 2015 18:26:46 +0100
Message-ID: <564E0656.9000709@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 67FC02614FB
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 18:26:48 +0100 (CET)
Received: by wmdw130 with SMTP id w130so249731004wmd.0
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 09:26:48 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm starting debugging / testing all the fsl_ssi issues (see Caleb's 
previous post).

First step I just need to setup a DTS entry for  "simple-card" + fake 
codec to generate arbitrary PCM bus output (1 to 16 channels, various 
TDM, various sampling rate and format and master/slave role)
I will then plug my logical analyser, or do some loopback, or plug a 
FPGA to generate/check some patterns.

Is there such "fake codec" somewhere.  Indeed, something that look like 
the bt-sco codec, but without rate/format/channel limitations ?
Or does the "simple-card" even needs one ?

Regards,
Arnaud
