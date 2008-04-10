From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: My issues with the ALSA API - mixer
Date: Fri, 11 Apr 2008 10:39:32 +1200
Message-ID: <47FE9724.6030907@audioscience.com>
References: <20080409221512.GA4466@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D51610380E
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 00:39:37 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JZ4001H8S9XQY40@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 11 Apr 2008 10:39:33 +1200 (NZST)
In-reply-to: <20080409221512.GA4466@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Greetings,

re Lennart's mixer comments (basically no way to find out grouping or 
connectivity between elements, some other constraints)

Does the info exposed by the intel-hda driver 
http://helllabs.org/codecgraph/
meet some or all of these requirements?

Would it be possible for
a) other drivers to export info in the same format
b) this info to be made part of the control api. I.e. adding nodes and 
connections to the control info
--
Eliot
