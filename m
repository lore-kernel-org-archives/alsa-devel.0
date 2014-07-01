From: Josh Lehan <alsa@krellan.com>
Subject: Re: [PATCH - alsa-utils 4/5] Documentation manual page
 for amidicat
Date: Tue, 01 Jul 2014 00:34:21 -0700
Message-ID: <53B2647D.3030200@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-5-git-send-email-alsa@krellan.com>
 <53B14AE4.20008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www7.pairlite.com (www7.pairlite.com [64.130.10.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C3DC264F03
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:34:23 +0200 (CEST)
In-Reply-To: <53B14AE4.20008@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/30/2014 04:32 AM, Clemens Ladisch wrote:
> Josh Lehan wrote:
>> +++ b/amidicat/amidicat.1
>> +.\" Generator: DocBook XSL Stylesheets v1.75.2 <http://docbook.sf.net/>
> 
> So this is not the actual source code?

It is.  In my original release I wrote the documentation page in DocBook
format.  This was handy, because both HTML and manpage formats could be
rendered from there.

However, I noticed DocBook wasn't used anywhere else in alsa-utils, and
I didn't want to pull in an external package just for that, so I made
the manpage format primary.  The "Generator" comment is now superfluous,
I will remove it.

>> +\fB\-\-hex\fR
>> ...
>> +If this option is not given, the default is raw binary data\&.
> 
> This is the only place in the documentation where the default input/
> output format is described.  Please move it to a more prominent
> location.

Good idea, thanks.

Josh
