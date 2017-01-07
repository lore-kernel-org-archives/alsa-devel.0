From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: gitcompile fail
Date: Sat, 7 Jan 2017 10:09:18 +0100
Message-ID: <bb84f9e4-f336-0b93-e82a-112c4094fd06@ladisch.de>
References: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 915742666B3
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2017 10:09:45 +0100 (CET)
In-Reply-To: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brand <mark.brand@nmmu.ac.za>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brand wrote:
> git clone git://github.com/tiwai/alsa-driver-build.git

Don't use that.  The ALSA drivers are part of the kernel; just compile
the kernel normally.

> git clone git://github.com/tiwai/sound.git

This is a kernel repository.


Regards,
Clemens
