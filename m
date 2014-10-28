From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/11] drivers: char: axd: add sysfs setup files
Date: Tue, 28 Oct 2014 22:11:54 +0800
Message-ID: <20141028141154.GB18384@kroah.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
 <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 11:26:27AM +0000, Qais Yousef wrote:
> lots of AXD configuration is exposed through sysfs, these
> files create all the necessary nodes to allow setting up AXD

Yet you don't document that interface through the required
Documentation/ABI/ files?  Why not?
