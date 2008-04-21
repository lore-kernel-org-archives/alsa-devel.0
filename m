From: Reuben Martin <reuben.m@gmail.com>
Subject: Alsa Callbacks and C++ classes
Date: Sun, 20 Apr 2008 21:28:25 -0500
Message-ID: <200804202128.25675.reuben.m@gmail.com>
Reply-To: Reuben Martin <reuben.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 9036510380B
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 04:28:18 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so805575hsb.0
	for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2008 19:28:16 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

I have an AES32 sound card that I am trying to write a general control 
interface for using qt4. I'm wanting to register callbacks so that the 
interface will reflect changes made by other apps. Now I'm not entirely up to 
speed on the API, but from what I can gather, the callback can be registered 
to call a regular function, or to change a public class variable.

Since I decided to use qt4, everything is in classes. Is there any way to have 
the callback trigger a public class function? I guess I don't understand why 
you would want to use a public variable instead. Wouldn't you have to set up 
a means within the class to continually pole the variable to see if it has 
been changed? Or can the option to call a regular function be used to call a 
public class function as well?

Go easy on me. I'm not much of an experienced programmer. More of a hack who 
can kinda get by with his sloppy programming most of the time.

Thanks,
-Reuben
