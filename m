From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DMA circular buffers - little help wanted
Date: Thu, 19 Jan 2017 17:25:57 +0100
Message-ID: <6a9feea3-c340-f856-3502-cc081bad2837@ladisch.de>
References: <d186cae9-0d45-16e2-a6dd-a42938eac3f8@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 32CC3266CC1
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 17:25:59 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id C56C05581266
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 17:25:58 +0100 (CET)
In-Reply-To: <d186cae9-0d45-16e2-a6dd-a42938eac3f8@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Petr Kulhavy wrote:
> But what is runtime->boundary good for?

It's a multiple of the buffer size.  Going beyond the actual buffer
allows tracking how many frames are missing when an underrun or overrun
happens.


Regards,
Clemens
