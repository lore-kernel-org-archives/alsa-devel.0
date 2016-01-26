From: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Subject: Porting codec driver to DT
Date: Tue, 26 Jan 2016 11:48:07 +0100
Message-ID: <20160126104807.GA9983@lnxandire1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 23762260527
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id C73601807D
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:09 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 44AZyQ2e3cBB for <alsa-devel@alsa-project.org>;
 Tue, 26 Jan 2016 11:48:09 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 3425C180E0
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:09 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 1D4231458
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:09 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 118EB13BD
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:09 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 0D20A3E37A
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 11:48:09 +0100 (CET)
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

Hi!

We're using the adau17x1 codecs in our products. They currently rely on
platform_data to provide information such as mic bias voltage, jack
detection and a few other hardware-specific parameters. As we want to
move to DT while still having support for the old platform_data way of
providing HW-specific information, this makes things a bit more complicated.

There are a few enums declared in <linux/platform_data/adau17x1.h> which
are used by the codec driver to distunguish between different
configurations. I'd like to use/provide these values in my .dts-file as well,
but that would mean either duplicating the definitions, or including
DT-specific parts in platform_data or vice versa. What would the Proper
(TM) way of implementing support for both be? I've peeked on other
drivers but it hasn't helped a lot.

At the moment I'm considering the solution of having a second set of
definitions in the DT path with slightly different names, and then
change the codec driver to use these definitions instead. If platform_data is
provided, there'll be some translation logic at probing time.

Any suggestions?
/Andreas
