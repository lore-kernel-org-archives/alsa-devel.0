From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Single vs. multiple seq client ports
Date: Wed, 04 Feb 2015 08:52:17 +0100
Message-ID: <54D1CFB1.8030407@ladisch.de>
References: <11961012.AHGMH1UnbJ@col-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 67E412606C5
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 08:52:19 +0100 (CET)
In-Reply-To: <11961012.AHGMH1UnbJ@col-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Tim E. Real" <termtech@rogers.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim E. Real wrote:
> What are the advantages and disadvantages if any, in terms
>  of speed and resources, of having a single client port versus
>  multiple client ports?

A port itself does not need much memory (it's just the name and other
metadata); as far as events are concerned, a port is just a number.
Events are stored in a client's buffer (in the sender's when they are
queued, in the receiver's when they are delivered).

A client's ports are stored in a linked list, and are looked up when
events are transmitted, so you should not have a very large number of
ports.

When the ports are visible to the user (because you want him to be able
to make connections dynamically), using multiple ports allows you to
expose different parts of your application (and use different
permissions, if this makes sense).  If the ports are not visible, it
might make sense to have multiple ones if you use the port number for
routing.


Regards,
Clemens
