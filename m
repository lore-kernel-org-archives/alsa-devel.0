From: debian@callistix.net
Subject: Support for Focusrite 18i20 audio interface
Date: Fri, 27 Jul 2018 19:59:57 +0200
Message-ID: <20180727175956.GA7620@callistix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from squirrel.callistix.net (squirrel.callistix.net
 [108.161.133.212])
 by alsa0.perex.cz (Postfix) with ESMTP id A46812675D4
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 20:00:23 +0200 (CEST)
Received: from callistix.net (unknown [37.223.38.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by squirrel.callistix.net (Postfix) with ESMTPSA id A0A3AD2898
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 20:00:19 +0200 (CEST)
Content-Disposition: inline
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

Hi everyone,

I own a Focusrite Scarlett 18i20 2nd Gen audio interface.
The inputs and outputs are supported by alsa out of the box, with jack all of them are visible and patchable.

But there are some functions which are not exposed by alsa, which include:

- low latency monitoring, apparently you are supposed to be able to patch any input to any headphone output
- selection of sample rates

Is someone working on adding this functionality?

As an owner of this hardware I would be able to support any dev who's willing to work on this.


User manuals: https://us.focusrite.com/downloads?product=Scarlett+18i20

Best regards,
vitaminx
