From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Wed, 16 Nov 2005 17:34:05 +0000
Message-ID: <437B6D8D.50101@superbug.co.uk>
References: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sameer.kittur@flextronicssoftware.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

sameer.kittur@flextronicssoftware.com wrote:
> Hi all,
> 
>     Is there a reason why Dmix cannot use a non SND_PCM_TYPE_HW slave? Is there 
> no way to re-direct the Dmix output to another plugin or an external I/O or a 
> filter plugin?
> 
> Thanks,
> Sameer.
> 

Why would you want to do this?
The purpose of dmix is to simply work around the limitation of the hardware.
If you want some other purpose, I would suggest using a sound server 
like arts or a different approach altogether like using jackd

James



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
