From: Perry Gilfillan <perrye@linuxmail.org>
Subject: Re: Any work on ALSA versions of tvmixer and tvaudio?
Date: Thu, 26 Feb 2004 18:32:52 -0600
Sender: video4linux-list-admin@redhat.com
Message-ID: <403E9034.6010903@linuxmail.org>
References: <403ACBA8.4050500@linuxmail.org>
Reply-To: video4linux-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-admin@redhat.com>
In-Reply-To: <403ACBA8.4050500@linuxmail.org>
Errors-To: video4linux-list-admin@redhat.com
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Post: <mailto:video4linux-list@redhat.com>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list/>
Cc: alsa-list <alsa-devel@lists.sourceforge.net>, v4l <video4linux-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

Perry Gilfillan wrote:
> Hello,
> 
> has any one done any work to develop ALSA versions of the tvmixer and 
> tvaudio mixer drivers?
> 
> Thanks,
> 
> Perry

So, no one was interested?

Well, I've made a first effort, and it works in it's way.

As far as I can tell the Segfaults are solved, and it loads and unloads 
cleanly!!  I'm waiting for my first user to try it out right now.

Sound does not come untill the scale tops 70%.  Treble does not get 
written to the msp3400 at all, and bass is all over the scale when 
written to the msp3400.  Got to do some work on the math...

I still need to read up on OSS/Free compatibility.

I've written a brief doc, and a patch plus the tvmixer.c source are here:

http://gilfillan.org:8000/ALSA/

Comments desired :)  Please note that I'm not a programmer by trade or 
training, so If I've made any obvious omissions or errors, please let me 
know!


-- 
-----
V3TV: http://gilfillan.org:8000/v3tv/
VPX3224: http://gilfillan.org:8000/vpx3224/
snd-tvmixer: http://gilfillan.org:8000/ALSA/


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
