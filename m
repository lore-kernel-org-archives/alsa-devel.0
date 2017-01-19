From: Petr Kulhavy <brain@jikos.cz>
Subject: DMA circular buffers - little help wanted
Date: Thu, 19 Jan 2017 16:45:44 +0100
Message-ID: <d186cae9-0d45-16e2-a6dd-a42938eac3f8@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-ch01-1.mx.upcmail.net
 (vie01a-dmta-ch01-1.mx.upcmail.net [84.116.36.91])
 by alsa0.perex.cz (Postfix) with ESMTP id CAEF3266CC1
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 16:45:52 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-ch01.mx.upcmail.net with esmtp (Exim 4.87)
 (envelope-from <brain@jikos.cz>) id 1cUEuN-0004dI-PT
 for alsa-devel@alsa-project.org; Thu, 19 Jan 2017 16:45:51 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to write a sound card driver and need a bit of help 
understanding the logic behind the DMA circular buffers.

I can understand there is a buffer of runtime->buffer_size frames, with 
two pointers: runtime->control->appl_ptr and runtime->status->hw_ptr 
pointing into it (they are actually offsets from the buffer start).
One pointer is the producer, the other consumer. So far a standard 
circular buffer as I know it. Please correct me if I'm wrong.

But what is runtime->boundary good for? It seems the arithmetics is not 
module buffer_size but modulo boundary, which is pretty confusing me.
According to the code and comments some values (like buffer "pointers", 
available space, free, space, etc.)  are supposed to be within 0 ... 
boundary - 1 and some within 0 ... buffer_size - 1. Not clear to me what 
is what and why.

Could someone please help me to understand the logic behind?

The other thing I would like to understand, how is the data positioned 
in time in terms of synchronisation? I mean where in the buffer, 
relative to the hw_ptr, is the frame that is supposed to play "now", for 
an arbitrary "now".

Thanks
Petr
