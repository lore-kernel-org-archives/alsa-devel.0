From: "Defiant" <mail@defiant.homedns.org>
Subject: RE: [ACPI] can't switch CPU frequency while running on batterypower
Date: Mon, 12 Jan 2004 07:51:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33039.192.168.36.2.1073890312.squirrel@defiant.homedns.org>
References: <3ACA40606221794F80A5670F0AF15F8401720CB1@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CB1@PDSMSX403.ccr.corp.intel.com
     >
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Did you find any warning or error message in boot log?
> Maybe there are some potential ACPI bug.

I get the cpufreq warning here:

ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [ATF0] (24 C)
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 255
cpufreq: No CPUs supporting ACPI performance management found.

DIsabling acpi performance managament doesn't change the 
/proc/acpi/processor/CPU0/limit output.

greetings,
Defiant


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
