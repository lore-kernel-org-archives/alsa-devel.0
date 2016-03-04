From: Puneet Sharma <punitsharma1181@gmail.com>
Subject: Re: USB audio2.0 status interrupt endpoint
Date: Fri, 4 Mar 2016 16:44:27 +0530
Message-ID: <CAJha+Vf5LDsD29HDbkyOorCM41P9Jgv6A66siUcF1ro7WEEYBw@mail.gmail.com>
References: <CAJha+Ve6wYyYMxU5FTpjDpih41OLmTWHX2UfOZZRAksJN6u8TA@mail.gmail.com>
 <56D83728.9090404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE8A260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 12:14:28 +0100 (CET)
Received: by mail-ob0-f169.google.com with SMTP id rt7so46865645obb.3
 for <alsa-devel@alsa-project.org>; Fri, 04 Mar 2016 03:14:28 -0800 (PST)
In-Reply-To: <56D83728.9090404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 3, 2016 at 6:37 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Puneet Sharma wrote:
> > As per my understanding, when the above interrupt endpoint is transferred
> > to host in response to Interrupt IN request, the host should send me a
> GET
> > CUR volume class-specific request to further qualify the cause of
> interrupt.
> >
> > However, I am not getting any class-specific request from host in
> response
> > to the status interrupt transferred to host.
> >
> > My query is do i need to implement a mixer interface in the uac2 kernel
> > driver to get the request or i am doing something wrong in the process.
>
> You must not send a notification for a unit ID that does not exist, so
> you must implement the mixer interface.
>
I have used a feature unit descriptor in the gadget driver with volume
control.
The Feature unit is inserted between Input and output terminal having
a unique Unit ID.

>
> And you will get a request to read the control's current volume only if
> some application that cares about the value (e.g., alsamixer) actually
> happens to be running on the host.
>
> Yes, I understand your point now.
After running alsamixer on host, I am able to send volume request to device
as well get volume request from host in response to status interrupt.

>
> Regards,
> Clemens
>
