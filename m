From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Calls from a custom dynamic shared library call
	the wrong version of alsa functions in libasound
Date: Wed, 10 Aug 2005 22:28:11 -0400
Message-ID: <1123727292.30766.0.camel@mindpipe>
References: <42FAB657.2070307@thehoytfamily.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42FAB657.2070307@thehoytfamily.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linux Coder <linux@thehoytfamily.com>
Cc: Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-10 at 22:22 -0400, Linux Coder wrote:
> I had created a library that is a dynamic shared library. Within this 
> library, calls are made to the ALSA Lib (libasound) but the wrong 
> version of the call is being made. If a single step through, it will 
> call __OLD_GET1(...). If my library is not a dynamic shared library then 
> the correct call is made.
> Am I doing something wrong or is the dynamic linker resolving to the 
> wrong version of the ALSA function call and there is not anything I can do?
> 

Well, you must have multiple ALSA version installed.  What does ldd
your_app say?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
