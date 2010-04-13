From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] USB: rename usb_buffer_alloc() and
	usb_buffer_free()
Date: Tue, 13 Apr 2010 23:47:01 +0200
Message-ID: <20100413214701.GU30801@buzzloop.caiaq.de>
References: <20100413181631.GT30801@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1004131525500.1551-100000@iolanthe.rowland.org>
	<20100413202607.GA3567@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 63528103843
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 23:47:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100413202607.GA3567@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@suse.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 13, 2010 at 01:26:07PM -0700, Greg KH wrote:
> I think I will split this up into the following set of patches:
> 	- rename the functions and add a macro for the old names
> 	- rename all in-kernel usages
> 	- rename the staging tree usages
> 	- remove the macros
> 
> the first patch can go in to Linus's tree now, to make it easier for the
> 2nd and 3rd patches to live in linux-next easier as we might need to
> look at the usages in other development trees before we can add the last
> one.
> 
> Sound good?

Yes, thanks a lot.

Daniel
