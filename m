From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: DMIX and capture stream
Date: Mon, 05 Jan 2004 15:00:28 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FF8FD7C.60508@boosthardware.com>
References: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net> <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com> <20040104145223.25bddac3.mista.tapas@gmx.net> <Pine.LNX.4.58.0401041746270.12698@ultros>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Lloyd <dmlloyd@tds.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Lloyd wrote:
> On Sun, 4 Jan 2004, Florian Schmidt wrote:
> 
> 
>>On Sun, 04 Jan 2004 00:07:26 -0500
>>Paul Davis <paul@linuxaudiosystems.com> wrote:
>>
>>
>>>>I'm working on changing DMIX to allow clients to open the capture
>>>>stream.  
>>>
>>>i don't get it. dmix is for playback, not capture. what would be the
>>>semantics of this?
>>
>>Hmm, i don't know the OP's answer to this, but i like to ask a very
>>related question:
>>
>>It is possible to create a playback pcm device with the help of the dmix
>>plugin. This way several apps can playback at once - nice. But now what
>>about using two apps that do full duplex at the same time?
> 
> 
> This is exacly my point.  The fact that dmix and dsnoop are half-duplex is
> where I have a problem.  There seems to be no way to allow more than one
> OSS-compatibility client to share audio in a satisfactory way.  Which is
> to say, you can have two doing playback, or two doing capture, or maybe
> one each (haven't tried yet), but you can't do two full-duplex, or one
> full-duplex and one capture or playback.  This is a bug in my opinion.  
> It seems to me that this issue is not addressed by anyone, and that's why 
> I started this code change, to allow capture to "pass through" so that one 
> client can do full-duplex with multiple other clients still able to 
> playback.  This is not too much to ask IMHO.
>

Recent discussion of this has made it clear that in the near future 
Jaroslav and Takashi are planning on implementing better 
interoperability between dmix and dsnoop.

It's not high on the list of priorities because there are already other 
software mixing apps/deamons that work. It is high on the list of 
desired features though :)

As you have found out the changes required are not superficial but 
require advanced understanding of ALSA internals.

dmix and dsnoop are less than a year old and there are still apps that 
don't provide correct support for them. If you can't wait, you could try 
  to use JACK, artsd, gstreamer....


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
