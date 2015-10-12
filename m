From: James Cameron <quozl@laptop.org>
Subject: Splitting out controls
Date: Tue, 13 Oct 2015 07:59:08 +1100
Message-ID: <20151012205908.GA25971@us.netrek.org>
References: <1444657786.2528.78.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D8C0261497
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 22:59:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.real-time.com (Postfix) with ESMTP id 37BD04A3384
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 15:59:34 -0500 (CDT)
Received: from zimbra.real-time.com ([127.0.0.1])
 by localhost (zimbra.real-time.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L+CHHsx-37xx for <alsa-devel@alsa-project.org>;
 Mon, 12 Oct 2015 15:59:33 -0500 (CDT)
Received: from esk.lan (pa220-236-7-241.pa.nsw.optusnet.com.au [220.236.7.241])
 by zimbra.real-time.com (Postfix) with ESMTPSA id 20CE24A29E7
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 15:59:33 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1444657786.2528.78.camel@loki>
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

On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
> I've written up the minutes here below

Thanks!

> Splitting out controls: Takashi
> ===============================
> 
>  - Restricted access.  Consensus to restrict access to some controls due
> to possibility of breaking HW at kernel level. i.e. prevent feeding
> digital Mic into HP amp to prevent speaker over heating.

I'd like that.  rt5631.  Avoiding at the moment by removing the controls.

-- 
James Cameron
http://quozl.linux.org.au/
