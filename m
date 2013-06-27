From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: How to clear the ALSA audio settings remembered by
 system?
Date: Thu, 27 Jun 2013 09:38:16 -0600
Message-ID: <51CC5C68.4000006@wwwdotorg.org>
References: <F46914AEC2663F4A9BB62374E5EEF8F80127A004@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 251212655F7
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 17:38:21 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F80127A004@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/27/2013 12:49 AM, Lin, Mengdong wrote:
> Hi,
> 
> Could anyone tell me how to clear the ALSA audio settings remembered by system?
> 
> I change some audio codec settings by amixer. And it seems the ALSA has remembered these settings and apply on next boot. And these will change my test result.
> How can I let system forgot these changes?

You're probably looking for /var/lib/alsa/asound.state
