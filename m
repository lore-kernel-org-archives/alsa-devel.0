From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB Audio device syncpipe error
Date: Fri, 10 Sep 2010 08:21:41 +0200
Message-ID: <20100910062141.GL7159@buzzloop.caiaq.de>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
	<4C8891D2.1020300@ladisch.de>
	<AANLkTingHyn2wyJ50uH9GpjnTg_YsL6Q0gzDoVyArvgv@mail.gmail.com>
	<AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AFD51038F2
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 08:21:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 6275 kson <6275.kson@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 09, 2010 at 04:51:45PM -0500, 6275 kson wrote:
> Well I basically understand what is wrong.  Usbaudio is expecting the packet
> size to be 4 and the value to be encoded as 16.16 because the device is
> operating at high speed.  I made the change and my device now shows up
> properly as an output device and playback works but the feedback polling
> interval is incorrect.
> 
> Since the feedback endpoint descriptor is not class specific I can see why
> one would expect it to be a usb 2.0 standard endpoint descriptor, however,
> that would mean I should also change my other audio streaming endpoint
> descriptors.
> 
> Unfortunately, I'm not sure the proper way to fix this - any advice would be
> appreciated.

Hmm, I don't get your point. Why don't you just change the bInterval
field of your endpoint descriptor? Does your device work with OSX, for
example?

Daniel
