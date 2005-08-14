From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Maximum number of sound devices
Date: Sun, 14 Aug 2005 21:33:22 +0100
Message-ID: <42FFAA92.10008@superbug.co.uk>
References: <8421d7b20508141324317a9aeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8421d7b20508141324317a9aeb@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Dunn <robert.j.dunn@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Robert Dunn wrote:
> What is the maximum number of capture devices ALSA supports?
> 
> I have spent the last hour or so, googing for an answer with no success.
> 
> The problem I have is a USB audio capture device.  The first eight work
> perfrect.  The 9th device on do not create /dev/dspX entries, and it appears
> that ALSA is limited to 8 devices.
> 
> Thanks for any help in advance.
> 
> Robert J. Dunn
> robert.j.dunn@gmail.com
> 

The default is 8, but it can be changed with a module option for module 
"snd"
See "modinfo snd"


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
