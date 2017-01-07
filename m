From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is exactly pcm.boundary?
Date: Sat, 7 Jan 2017 10:06:26 +0100
Message-ID: <a4260e01-f6e4-118b-b91e-0012bd0219da@ladisch.de>
References: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
 <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
 <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
 <922adfc9-c436-905a-466e-7fbba239439e@ladisch.de>
 <CAAu8FseE8M-6bynuphCK5HxnpqKzh_Y_bmeHEf6meTTD4bU2eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AFF73266A51
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2017 10:06:52 +0100 (CET)
In-Reply-To: <CAAu8FseE8M-6bynuphCK5HxnpqKzh_Y_bmeHEf6meTTD4bU2eA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl <rbpoficial@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ricardo Biehl wrote:
> I'm developing a "live microphone system over local network" which are user
> space programs (clients => server) transferring audio nearly real-time
> (human imperceptible latency).
> I need to elaborate a good solution of implementation to have everything working
> as expected -- networking, scheduling, IO management etc -- However I need at
> first make sure I can get control over audio.
>
> I decided to use ioctl() level of communication with ALSA in kernel

Neither using ioctls directly nor using mmap will reduce latency.

First get it correct with the normal ALSA API.


Regards,
Clemens
