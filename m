From: mateen <abdulmateen.shaikh@gmail.com>
Subject: Issue with Dmix
Date: Mon, 25 Feb 2013 11:38:58 +0530
Message-ID: <CADryByFhCKh0VjkCpeqj=y1XAWxqAL+eFu04AMerncgenDo38Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f177.google.com (mail-ve0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id DA71B26514B
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 07:08:59 +0100 (CET)
Received: by mail-ve0-f177.google.com with SMTP id m1so1899065ves.22
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 22:08:59 -0800 (PST)
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

HI



We have enabled DMIX plugin for sample rate conversion and mixing of 2 pcm
streams in our alsa package (Alsa lib 1.0.22 and alsa driver 1.0.22.1)  to
48K output Sample rate.However we are seeing a noise issue with 44100
Sample rate input streams or Unsigned Stereo 48K stream.



This is how our current design  is:

We call snd_pcm_lib_malloc_page() in which alsa driver internally allocates
a dma buffer and map it when Dmix is invoked.

We currently reads from that mmaped buffer to our hardware buffer inside a
transfer_ack_begin() function which is called from snd_pcm_period_elapsed().

However we are getting a problem in understanding how do we know how much
data has been written by dmix lib in mapped buffer? As we see no ioctl or
corresponding hardware function call where dmix may pass information on
Size of data being written to our driver.



We do see appl_ptr and hw_ptr in runtime->mmap->control and status struct.
Out architecture doesn=92t support defining and mapping of these status and
control structure at hardware level.Thus Dmix lib allocates them and copy
them to runtime substream via ioctl. As far as I could understand both
appl_ptr and hw_ptr are initialised to 0 and then appl_ptr is the one
adjusted by lib after every write. Should we tap this value to update
hw_ptr value in status information? Will difference of hw_ptr and appl_ptr
will let us know amount of frames been written?

Can anyone please help us to understand criteria and concept of data copy
from intermediate to hardware buffer?

Any information on this would be of immense help.


Regards,
Shaikh Mateen
