From: maillist@superlative.org
Subject: Idea: dynamic loading of USB quirks
Date: Wed, 31 Oct 2012 23:32:49 +0000
Message-ID: <2390628.MpxcLPPhM0@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CA1C2616C8
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 00:40:43 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id ed3so1019326wgb.20
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 16:40:42 -0700 (PDT)
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

Dear Alsa community,
I've some minor contributions in the form of patches for USB quirks for 
devices in the past. It occurred to me that having these USB quirks hardcoded 
into the driver maybe isn't the best thing.

Looking at the current quirks file, the majority of them are relatively trivial 
and are really just there to give the USB driver a nudge in the right 
direction.

Having to have these hardcoded into the driver creates a number of issues:

1. It needs someone with the expertise and will, and access the specific device 
for testing, to build the quirk. To hardened ALSA hackers this seems trivial, 
but to an average end user who has a device they want to get supported, this 
can be pretty inpenatrable. The complexity of just getting the alsa source 
installed and set up for compilation is enough to put off the vast majority of 
users.

2. It makes the process of getting the driver "to market" lengthy as these 
changes have to go through all of the normal release schedules, and these are 
pretty opaque.

3. It makes getting changing a driver (because of a bug, or a new release of 
hardware) difficult as the revisions need to go through the whole process of 
creating a patch, getting it accepted, and then the long kernel release 
process, as well as the various distribution release processes.

It occured to me that there might be a better way where quirks like this could 
be dynamically loaded into the driver after it has loaded. This would a 
structured text file describing the quirk to be created and pushed into the 
driver. Ultimately this could be wrapped into a framework where quirk files 
could be put into a common directory (similar to modprobe.d) with a startup 
script which pushed these into the driver.

At the moment I don't have any specific thoughts about how to do this, but I 
thought it would be useful to elicit ideas from this community. The way I see 
it it needs:

* A structured file format to describe the quirks
* A basic method to push these files into the driver at runtime (sysfs?)
* Some sort of dynamic data area for the driver to store the data
* changes to the driver to accept, store and process these data structures

At the moment I just thought I would get people thinking about this and, 
perhaps, making suggestions about whether it makes sense, whether it's 
practically achievable within the framework of the kernel and ALSA, and 
possible methods which might lead to a solution.

If I get the time (and, at the moment, that's unlikely for the next 6 months) 
I'll look at trying to code something up. If anyone else is inspired and feels 
like having a crack at it, then feel free.

All comments and discussion welcome.

Cheers,

Keith 
