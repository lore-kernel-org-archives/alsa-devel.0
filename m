From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: compressed audio support
Date: Mon, 2 Dec 2013 13:16:31 +0530
Message-ID: <20131202074631.GL8834@intel.com>
References: <CANv6ZMbWdO9F0DPeTwWHwo9mn5Xp1zuewS7U6tK9JCsMhVX9rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CA702619F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 09:44:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANv6ZMbWdO9F0DPeTwWHwo9mn5Xp1zuewS7U6tK9JCsMhVX9rw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 01, 2013 at 11:23:06PM +0530, maruthi srinivas wrote:
> Hi,
> 
> I saw that compressed audio framework being used with Asoc (alsa soc).
> Can the framework be used with other than Asoc ? I mean with ALSA pci based
> cards.
Yes it can be, the PCI sound card would in this case directly call the register
APIs.

Do you have a PCI device which supports offload?

> I see the implementation in the following files. which one is to be used ?
> Does tinycompress in userspace can be used with either approaches ?
Usermode does not care what is under the hood. It simply needs to see a
compressed device entry /dev/snd/comprCxDy

--
~Vinod
