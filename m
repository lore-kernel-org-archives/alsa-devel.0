From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to properly restart after config change
Date: Fri, 29 Nov 2013 14:06:12 +0100
Message-ID: <52989144.2010105@ladisch.de>
References: <DUB122-W2DB54619B660931AC34D8AAE90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 14CF326557D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 14:06:14 +0100 (CET)
In-Reply-To: <DUB122-W2DB54619B660931AC34D8AAE90@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dolevo Jay <cmst@live.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dolevo Jay wrote:
> In my application, I some parameters in the asound.conf at runtime.
> However, after my software edits and changes the necessary parameters,
> the application still runs with the old configuration.

The configuration is cached by alsa-lib.  Run snd_config_update().


Regards,
Clemens
