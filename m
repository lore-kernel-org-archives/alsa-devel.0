From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio2.0 status interrupt endpoint
Date: Thu, 3 Mar 2016 14:07:52 +0100
Message-ID: <56D83728.9090404@ladisch.de>
References: <CAJha+Ve6wYyYMxU5FTpjDpih41OLmTWHX2UfOZZRAksJN6u8TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 75F03260535
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 14:07:54 +0100 (CET)
In-Reply-To: <CAJha+Ve6wYyYMxU5FTpjDpih41OLmTWHX2UfOZZRAksJN6u8TA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Puneet Sharma <punitsharma1181@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Puneet Sharma wrote:
> As per my understanding, when the above interrupt endpoint is transferred
> to host in response to Interrupt IN request, the host should send me a GET
> CUR volume class-specific request to further qualify the cause of interrupt.
>
> However, I am not getting any class-specific request from host in response
> to the status interrupt transferred to host.
>
> My query is do i need to implement a mixer interface in the uac2 kernel
> driver to get the request or i am doing something wrong in the process.

You must not send a notification for a unit ID that does not exist, so
you must implement the mixer interface.

And you will get a request to read the control's current volume only if
some application that cares about the value (e.g., alsamixer) actually
happens to be running on the host.


Regards,
Clemens
