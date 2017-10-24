From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: conflict between alsa-lib and libasound2-data
 regarding alsa.conf file:
Date: Tue, 24 Oct 2017 14:06:39 +0300
Message-ID: <1508843199.2665.34.camel@iki.fi>
References: <20171023185824.38c4566e@fx4100>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2B790266DD4
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 13:06:42 +0200 (CEST)
In-Reply-To: <20171023185824.38c4566e@fx4100>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arne <sp113438@telfort.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-10-23 at 18:58 +0200, arne wrote:
> Hi,
> 
> Debian conflicts between alsa-lib_1.1.4 and libasound2-data 1.1.3:
> 
> in the source tree of alsa-lib I do:
> 
> ./configure && make && sudo checkinstall
> 
> and the result is:
> 
> Unpacking alsa-lib (1.1.4.1-1) ...
> dpkg: error processing
> archive /home/temp/alsa-lib-1.1.4.1/alsa-lib_1.1.4.1-1_amd64.deb
> (--install): trying to overwrite '/usr/share/alsa/alsa.conf', which is
> also in package libasound2-data 1.1.3-5

This is a Debian packaging issue. It's better to contact the Debian
alsa-lib package maintainer(s) directly.

-- 
Tanu

https://www.patreon.com/tanuk
